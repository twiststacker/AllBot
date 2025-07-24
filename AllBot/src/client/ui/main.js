document.getElementById('btn').onclick = async () => {
  const res = await fetch('/api/throttle');
  const data = await res.json();
  document.getElementById('out').innerText = JSON.stringify(data, null, 2);
};
