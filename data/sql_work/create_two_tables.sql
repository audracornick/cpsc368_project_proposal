CREATE TABLE HealthExpenditure_SurgicalWaitTimes AS
SELECT 
    he.ID AS HealthExpenditure_ID, -- or whatever unique identifier you want
    he.Year,
    he.Gender,
    he.AgeGroup,
    st.HealthAuthority,
    st.HospitalName,
    st.Category,
    st.Waiting,
    st.Completed,
    st.COMPLETED_50TH_PERCENTILE,
    st.COMPLETED_90TH_PERCENTILE
FROM HealthExpenditure he
JOIN SurgicalWaitTimes st
    ON he.Year = st.Year;