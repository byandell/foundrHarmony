#' Harmonize module object
#'
#' @param datasetname name to give to dataset (here for compatibility)
#' @param object object of class traitModule
#' @param links data frame with links (not used yet)
#' @param responsename name of response to extract
#' @param ... additional parameters ignored
#' @param datatraits incorporate `dataset` into `trait` if `TRUE`
#' @param traitparams incorporate key `params` into `trait` if `TRUE`
#'
#' @return harmonize object
#' @export
#' @rdname userHarmony
#' @importFrom dplyr bind_rows everything filter mutate select
#' @importFrom tidyr pivot_longer separate_wider_delim unite
#' @importFrom purrr transpose
#' @importFrom tibble rownames_to_column
#' @importFrom rlang .data
#'
moduleHarmony <- function(datasetname,
                          links,
                          object,
                          responsename = names(object[[1]]),
                          ...,
                          datatraits = FALSE,
                          traitparams = FALSE) { 
  if(is.null(object))
    return(NULL)
  
  responsename <- match.arg(responsename)
  
  # This needs to be modified:
  # 1) add minSize and cutHeight
  # 2) specific to dataset$response
  params <- attr(object[[1]], "params")
  params_sign_power <- paste0(
    stringr::str_sub(params$signType, 1, 1),
    params$power)
  
  out <-
    # Select only one response
    dplyr::select(
      dplyr::filter(
        # Unite carb and fat into diet = condition. **Specific to Founder Diet Study**
        tidyr::unite(
          # Separate ID into strain, sex, condition, animal.
          # But it over-separates as condition = carb_fat.
          tidyr::separate_wider_delim(
            # Process each response for each dataset.
            dplyr::bind_rows(
              lapply(
                purrr::transpose(object),
                # Get eigen data frame for each dataset:
                #     put rowname in ID column,
                #.    pivot module columns longer into trait and value,
                #.    bind together across datasets.
                function(x) {
                  nonnull_dataset <- !sapply(x, is.null)
                  x <- x[nonnull_dataset]
                  dplyr::bind_rows(
                    lapply(
                      purrr::transpose(x)$eigen,
                      function(y) {
                        tidyr::pivot_longer(
                          tibble::rownames_to_column(y, "ID"),
                          -ID,
                          names_to = "trait", values_to = "value")
                      }),
                    .id = "dataset")
                }),
              .id = "response"),
            .data$ID,
            delim = "_",
            names = c("strain", "sex", "carb", "fat", "animal"),
            # Responses cellmean and signal do not have `animal`.
            too_few = "align_start"),
          condition,
          .data$carb, .data$fat),
        .data$response == responsename),
      -.data$response)
  
  if(traitparams) {
    # Add params_sign_power to end of dataset column name
    out <- dplyr::mutate(out,
      dataset = paste(.data$dataset, params_sign_power, sep = "_"))
  }
  
  # Harmonize selection and order of columns.
  out <- dplyr::select(out,
    .data$dataset, .data$trait, .data$strain, .data$sex, .data$animal, .data$condition, .data$value)

  if(datatraits) {
    # Unite dataset and trait into trait column name
    out <- tidyr::unite(out, trait, .data$dataset, .data$trait)
  }
  
  out
}