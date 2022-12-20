# =============================================================================
# Define functions
# =============================================================================

rename_to_match_args <- function(df) {

	df |>
	dplyr::rename(
		interview__id = interviewId,
		interview__status = status
	)

}

# =============================================================================
# Run functions to approve/reject in batch
# =============================================================================


# injest interview list, filtering to those with an approve/reject decision
interview_list <- readxl::read_excel(
		path = fs::path(here::here(), interview_file), 
		sheet = sheet_name
	) |>
	dplyr::select(interviewId, decision, status, comment) |>
	dplyr::filter(!is.na(decision))

# interviews to approve
to_approve <- interview_list |>
	dplyr::filter(decision == "approve") |>
	dplyr::select(interviewId, status, approve_comment = comment) |>
	dplyr::mutate(comment = as.character(approve_comment)) |>
	rename_to_match_args()

# interviews to reject
to_reject <- interview_list |> 
	dplyr::filter(decision == "reject") |>
	dplyr::select(interviewId, status, reject_comment = comment) |>
	dplyr::mutate(comment = as.character(reject_comment)) |>
	rename_to_match_args()

# approve: apply `approve_interview()` function to each interview in the interview list
if (nrow(to_approve) > 0) {
	purrr::pwalk(
		.l = to_approve,
		.f = susoreview::approve_interview,
		statuses_to_approve = statuses_to_approve
	)
}

# reject: apply the `reject_interview()` function to each interview in the interview list
if (nrow(to_reject) > 0) {

	# reject from current status to next status lower in statuses
	purrr::pwalk(
		.l = to_reject,
		.f = susoreview::reject_interview,
		statuses_to_reject = statuses_to_reject
	)

	# reject intially HQ-approved cases to interviewers
	obs_hq_approved <- to_reject |> 
		dplyr::filter(interview__status == 130) |>
		dplyr::select(
			interview_id = interview__id, 
			comment = reject_comment
		)

	if (nrow(obs_hq_approved) > 0) {
		purrr::pwalk(
			.l = obs_hq_approved,
			.f = susoapi::reject_interview_as_sup
		)
	}

}
