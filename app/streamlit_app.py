import streamlit as st
from snowflake.snowpark.context import get_active_session

st.title("📊 Information Mart Dashboard")
session = get_active_session()

df = session.sql("SELECT * FROM dv_lab.l30_id.fct_customer_order LIMIT 100").to_pandas()
st.dataframe(df)

if not df.empty and "EFFECTIVE_DTS" in df.columns:
    chart_data = df.groupby("EFFECTIVE_DTS").size()
    st.line_chart(chart_data)