-- Clinical Trial Funnel View
-- Shows number of active trials and enrollments by phase

CREATE OR REPLACE VIEW analytics.clinical_trial_funnel AS
SELECT
    ct.phase,
    COUNT(DISTINCT ct.trial_id) AS total_active_trials,
    COUNT(tp.participant_id) AS total_enrollments
FROM research.clinical_trials ct
LEFT JOIN research.trial_participants tp
    ON ct.trial_id = tp.trial_id
WHERE ct.status IN ('Active', 'Recruiting')
GROUP BY ct.phase
ORDER BY ct.phase;