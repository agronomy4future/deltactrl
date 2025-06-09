#' Calculate the responsiveness of each treatment relative to a control.
#'
#' Computes relative change of one or more response variables with respect to a specified control treatment,
#' within user-defined groups.
#'
#' @param data A data frame containing the experimental data.
#' @param group_vars A character vector specifying the grouping variables (e.g., c("Genotype", "Block")).
#' @param treatment_var Unquoted name of the treatment variable column (e.g., `Treatment` or `Fertilizer`).
#' @param control_label Unquoted label identifying the control treatment level (e.g., `Control`).
#' @param response_vars A character vector of numeric response variable names (e.g., c("Yield", "Height")).
#'
#' @return A data frame with new columns added for each response variable, prefixed with `responsive_`, containing
#' relative change values compared to the control.
#'
#' @details The responsiveness is calculated as:
#' \deqn{(value - mean(control)) / mean(control)}
#' where "mean(control)" is the group-specific mean of the control level.
#' NA values in response variables are preserved.#'
#'
#' @examples
#' \dontrun{
#'
#'# upload required package
#'if(!require(remotes)) install.packages("remotes")
#'if (!requireNamespace("descriptivestat", quietly = TRUE)) {
#' remotes::install_github("agronomy4future/deltactrl", force= TRUE)
#'}
#'library(remotes)
#'library(deltactrl)
#'
#'Fungicide = c("No","No","No","Yes","Yes","Yes")
#'Fertilizer = c("Control","Fast","Slow","Control","Fast","Slow"),
#'Yield = c(110.3,119.2,137, 139.5,135.9,156.3
#'df=data.frame(Fungicide,Fertilizer,Yield)
#'
#'df1 = deltactrl(
#'                data = df,
#'                group_vars = c("Fungicide"),
#'                treatment_var = Fertilizer,
#'                control_label = Control,
#'                response_vars = c("Yield")
#' )
#' }
#'
#' Fungicide  Fertilizer  Yield  responsive_Yield
#'1 No        Control     110.   NA
#'2 No        Fast        119.   0.0807
#'3 No        Slow        137    0.242
#'4 Yes       Control     140.   NA
#'5 Yes       Fast        136.   -0.0258
#'6 Yes       Slow        156.   0.120
#'
#' * Code source: https://github.com/agronomy4future/deltactrl
#'
#' @import dplyr
#' @importFrom rlang ensym as_string
#' @export
deltactrl= function(data, group_vars, treatment_var, control_label, response_vars) {

  if(!require(readxl)) install.packages("dplyr")
  if(!require(readxl)) install.packages("rlang")
  library(dplyr)
  library(rlang)

  treatment_sym= ensym(treatment_var)
  control_str= as_string(ensym(control_label))

  data %>%
    group_by(across(all_of(group_vars))) %>%
    mutate(across(all_of(response_vars),
                  ~ ifelse(
                    !is.na(.) & !!treatment_sym!= control_str,
                    (. - mean(.[!!treatment_sym== control_str], na.rm= TRUE)) /
                      mean(.[!!treatment_sym== control_str], na.rm= TRUE),
                    NA_real_
                  ),
                  .names= "responsive_{.col}"
    )) %>%
    ungroup()
}
