# =============================================================================
# Check parameters provided by the user
# =============================================================================

# -----------------------------------------------------------------------------
# File
# -----------------------------------------------------------------------------

file_path <- fs::path(here::here(), interview_file)

# file exists in folder
if (!file.exists(file_path)) {
	stop(paste0("File does not exist where indicated: ", paste0(project_folder, interview_file)))
}

# file is Excel
if (!stringr::str_detect(interview_file, "\\.xls[x]*$")) {
	stop(paste0("File with list of interviews is not an Excel file: ", interview_file))
}

# sheet exists in Excel file
sheet_names <- readxl::excel_sheets(file_path)
if (!sheet_name %in% sheet_names) {
	stop(glue::glue(
		"The target sheet, {sheet_name}, does not exist.",
		"The sheets found in the file are {glue::glue_collapse(sheet_names, sep = ', ')}",
		.sep = "\n"
	))
}

# file contains expected columns
cols_expected <- c("interviewId", "decision", "status", "comment")
cols_in_file <- file_path  |>
	readxl::read_excel(sheet = sheet_name) |> 
	names()

if (!all(cols_expected %in% cols_in_file)) {
	
	cols_missing <- cols_expected[! cols_expected %in% cols_in_file]
	
	stop(glue::glue(
		"Required columns missing.", 
		"Columns expected: {glue::glue_collapse(cols_expected, sep = ', ')}",
		"Columns missing: {glue::glue_collapse(cols_missing, sep = ', ')}",
		.sep = "\n"
	))
	
}

# -----------------------------------------------------------------------------
# Server
# -----------------------------------------------------------------------------

# server exists
server_exists <- function(url) {

	tryCatch(
		expr = httr::status_code(httr::GET(url = url)) == 200,
		error = function(e) {
			FALSE
		}
	)
}

if (!server_exists(url = server)) {
	stop(paste0("Server does not exist at address provided: ", server))
}

# server credentials valid
credentials_valid <- suppressMessages(
	susoapi::check_credentials(
		verbose = TRUE
	)
)

if (credentials_valid == FALSE) {
	susoapi::check_credentials(
		verbose = TRUE
	)	
	stop("Credentials invalid.")

}
