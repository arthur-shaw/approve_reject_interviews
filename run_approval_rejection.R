# =============================================================================
# Provide user-specified parameters
# =============================================================================

# SuSo server details
server 		<- "" 	# Server name. 
workspace   <- ""   # Workspace name. Use the name that is an ID rather than the display name.
user 		<- "" 	# User name. Note: user must be either admin or API user.
password 	<- "" 	# Password of the user indicated above.

susoapi::set_credentials(
	server = server,
	workspace = workspace,
	user = user,
	password = password
)

# Where file with interviews to approve is located
interview_file 	<- "" 	# File name. Note: include extension
sheet_name 		<- "" 	# Sheet name. 
									# Expected columns in sheet: interviewId, decision, status, comment
									# decision expects values "accept" or "reject" to act; decision may be empty or contain other values

# statuses to review
# see here for values of statuses: https://docs.mysurvey.solutions/headquarters/export/system-generated---export-file-anatomy/#coding_status
statuses_to_reject <- c(100, 120)
statuses_to_approve <- c(100, 120)

# =============================================================================
# Run programs
# =============================================================================

script_dir <- fs::path(here::here("R"))

# check user-provided parameters
source(fs::path(script_dir, "check_user_provided_params.R"))

# execute approve and reject operations
source(fs::path(script_dir, "approve_and_reject.R"))
