<template>
  <button class="theme-button" @click="toggleTheme">
    <svg fill="var(--primary-color)" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
         width="18px" height="18px" viewBox="0 0 491.535 491.535"
         xml:space="preserve">
      <g>
        <g>
          <g id="Icons_9_">
            <g>
              <path d="M306.545,367.594H185.003c-9.041,0-16.382,7.338-16.382,16.385c0,9.05,7.341,16.384,16.382,16.384h121.542
                c9.041,0,16.389-7.334,16.389-16.384C322.934,374.932,315.586,367.594,306.545,367.594z"/>
              <path d="M213.917,464.367v8.926c0,10.076,8.157,18.242,18.239,18.242h27.233c10.062,0,18.239-8.166,18.239-18.242v-8.926
                c20.642-1.467,36.981-18.498,36.981-39.506H176.92C176.921,445.869,193.277,462.9,213.917,464.367z"/>
              <path d="M245.777,0C155.084,0,81.561,73.516,81.561,164.207c0,38.268,13.164,73.396,35.152,101.287
                c19.444,24.647,37.874,51.592,53.76,78.688h150.583c16.049-27.353,34.146-53.793,53.78-78.707
                c21.968-27.878,35.139-63.011,35.139-101.27C409.975,73.517,336.451,0,245.777,0z M246.05,56.971
                c-58.297,0-105.702,47.412-105.702,105.692c0,9.048-7.327,16.385-16.389,16.385c-9.056,0-16.383-7.337-16.383-16.385
                c0-76.346,62.114-138.46,138.474-138.46c9.034,0,16.383,7.334,16.383,16.382S255.084,56.971,246.05,56.971z"/>
            </g>
          </g>
        </g>
      </g>
    </svg>
  </button>
</template>

<script setup>
  /* Libraries */
  import { ref,onMounted } from 'vue'

  /* Variables */
  const isDarkTheme = ref(false);

  /* onMounted */
  onMounted(() => { // Load the theme from local storage
    const savedTheme = localStorage.getItem('theme') || 'light'; // Default is light theme
    isDarkTheme.value = savedTheme === 'dark'; // Set isDarkTheme
    applyTheme(savedTheme); // Apply the saved theme
  });

  // Function to get the value of a CSS variable
  const getCssVariable = (variableName) => {
    const root = getComputedStyle(document.documentElement);
    return root.getPropertyValue(variableName).trim();
  };

  // Function to apply theme
  const applyTheme = (theme) => {
    const root = document.documentElement;
    // Set the CSS variables based on the theme
    if (theme === 'dark') {
      root.style.setProperty('--color-background', getCssVariable('--dark-matcha'));
      root.style.setProperty('--primary-color', getCssVariable('--cream'));
      root.style.setProperty('--secondary-color', getCssVariable('--matcha'));
      root.style.setProperty('--tertiary-color', getCssVariable('--light-matcha'));
    } else {
      root.style.setProperty('--color-background', getCssVariable('--cream'));
      root.style.setProperty('--primary-color', getCssVariable('--dark-matcha'));
      root.style.setProperty('--secondary-color', getCssVariable('--light-matcha'));
      root.style.setProperty('--tertiary-color', getCssVariable('--matcha'));
    }
  };

  // Function to toggle theme
  const toggleTheme = () => {
    isDarkTheme.value = !isDarkTheme.value;
    const theme = isDarkTheme.value ? 'dark' : 'light';
    applyTheme(theme);
    localStorage.setItem('theme', theme); // Save the toggled theme to local storage
  };
</script>

<style scoped>
  .theme-button {
    position: fixed;
    top: 15px;
    left: 15px;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
  }
</style>