import streamlit as st
import psutil

st.set_page_config(page_title="SemirSuite Dashboard", layout="wide")

def display_system_health():
    col1, col2 = st.columns(2)

    with col1:
        st.metric(label="CPU Usage", value=f"{psutil.cpu_percent()}%")
        disk_usage = psutil.disk_usage('/')
        st.metric(label="Disk Usage", value=f"{disk_usage.percent}%")

    with col2:
        st.metric(label="Memory Usage", value=f"{psutil.virtual_memory().percent}%")
        network_io = psutil.net_io_counters()
        st.metric(label="Network Bytes Sent", value=f"{network_io.bytes_sent / (1024 * 1024):.2f} MB")

st.title("SemirSuite System Health Dashboard")
display_system_health()
