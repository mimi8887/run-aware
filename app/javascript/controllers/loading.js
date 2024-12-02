const loader = document.getElementById('loader');

function showLoader() {
  loader.classList.remove('hidden');
}

function hideLoader() {
  loader.classList.add('hidden');
}

document.addEventListener('turbo:click', () => {
  showLoader();
});

document.addEventListener('turbo:load', () => {
  hideLoader();
});

async function fetchData(url) {
  try {
    showLoader();
    const response = await fetch(url);
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error('Erro ao buscar dados:', error);
  } finally {
    hideLoader();
  }
}
