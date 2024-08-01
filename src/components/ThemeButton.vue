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
  import { ref } from 'vue';
  const isDarkTheme = ref(true);
  const toggleTheme = () => {
    const root = document.documentElement;
    if (isDarkTheme.value) {
      root.style.setProperty('--color-background', getCssVariable('--cream'));
      root.style.setProperty('--primary-color', getCssVariable('--dark-matcha'));
      root.style.setProperty('--secondary-color', getCssVariable('--light-matcha'));
      root.style.setProperty('--tertiary-color', '--matcha');
    } else {
      root.style.setProperty('--color-background', getCssVariable('--dark-matcha'));
      root.style.setProperty('--primary-color', getCssVariable('--cream'));
      root.style.setProperty('--secondary-color', getCssVariable('--matcha'));
      root.style.setProperty('--tertiary-color', getCssVariable('--light-matcha'));
    }
    isDarkTheme.value = !isDarkTheme.value;
  };

  // Function to get the value of a CSS variable
  const getCssVariable = (variableName) => {
    const root = getComputedStyle(document.documentElement);
    return root.getPropertyValue(variableName).trim();
  };
</script>

<style scoped>
.theme-button {
  position: fixed;
  top: 15px;
  left: 15px;
  width: 32px;
  height: 32px;
  border: 2px solid var(--primary-color);
  border-radius: 10px;
  background-color: var(--secondary-color);
  margin: 5px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.theme-button:focus {
  outline: none;
  border: 3px solid var(--primary-color);
}
.theme-button:active {
  transform: scale(0.95);
  filter: brightness(110%);
}
</style>