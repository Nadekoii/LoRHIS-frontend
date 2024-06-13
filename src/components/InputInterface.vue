<template>
  <div class="left-div">
    <h1>LORHIS</h1>
    <h4>Enter your text</h4>
    <div class="input-container">
      <input class="message-input" placeholder="Your message..." v-model="userInput">
      <button class="text-input-button" @click="enterInput">
        <svg class="svg-icon" style=" width: 16px; height: 16px; vertical-align: middle; fill: var(--primary-color);overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M804.248575 157.915589l0 431.250908L393.361461 589.166497 393.361461 407.414013l-265.620613 227.143277 265.620613 227.01741L393.361461 679.95013l456.278931 0c25.086351 0 45.391816-20.36277 45.391816-45.39284L895.032208 157.915589 804.248575 157.915589 804.248575 157.915589zM804.248575 157.915589"  /></svg>
      </button>
    </div>
    <h4>or record your voice</h4>
    <button class="mic-button" @click="voiceInput">
      <svg class="mic-svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="20" height="20" viewBox="0 0 256 256" xml:space="preserve">\
        <defs/>
        <g style="stroke: none; stroke-width: 0; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: var(--primary-color); fill-rule: nonzero; opacity: 1;" transform="translate(1.4065934065934016 1.4065934065934016) scale(2.81 2.81)" >
          <path d="M 45 70.968 c -16.013 0 -29.042 -13.028 -29.042 -29.042 c 0 -1.712 1.388 -3.099 3.099 -3.099 c 1.712 0 3.099 1.388 3.099 3.099 C 22.157 54.522 32.404 64.77 45 64.77 c 12.595 0 22.843 -10.248 22.843 -22.843 c 0 -1.712 1.387 -3.099 3.099 -3.099 s 3.099 1.388 3.099 3.099 C 74.042 57.94 61.013 70.968 45 70.968 z" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: var(--primary-color); fill-rule: nonzero; opacity: 1;" transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
          <path d="M 45 60.738 L 45 60.738 c -10.285 0 -18.7 -8.415 -18.7 -18.7 V 18.7 C 26.3 8.415 34.715 0 45 0 h 0 c 10.285 0 18.7 8.415 18.7 18.7 v 23.337 C 63.7 52.322 55.285 60.738 45 60.738 z" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: var(--primary-color); fill-rule: nonzero; opacity: 1;" transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
          <path d="M 45 89.213 c -1.712 0 -3.099 -1.387 -3.099 -3.099 V 68.655 c 0 -1.712 1.388 -3.099 3.099 -3.099 c 1.712 0 3.099 1.387 3.099 3.099 v 17.459 C 48.099 87.826 46.712 89.213 45 89.213 z" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: var(--primary-color); fill-rule: nonzero; opacity: 1;" transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
          <path d="M 55.451 90 H 34.549 c -1.712 0 -3.099 -1.387 -3.099 -3.099 s 1.388 -3.099 3.099 -3.099 h 20.901 c 1.712 0 3.099 1.387 3.099 3.099 S 57.163 90 55.451 90 z" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: var(--primary-color); fill-rule: nonzero; opacity: 1;" transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
        </g>
      </svg>
    </button>
  </div>
</template>

<script setup>
  import{ ref } from 'vue'; //reactive data - JS variable where Vue is aware of any changes to it => like data()

  const userInput = ref('');
  const enterInput = () => {
    // TODO smt = userInput.value;
    userInput.value = '';
  }
  const voiceInput =() =>{
    // TODO voice input function
  }

</script>

<style scoped>
  h1{
    font-size: 64px;
    font-weight: bold;
  }
  h2{
    font-size: 48px;
    font-weight: bold;
  }
  h4{
    font-size: 32px;
  }
  .left-div{
    border-top-left-radius: 30px;
    border-bottom-left-radius: 30px;
    border-top: 1px dashed var(--primary-color);
    border-left: 1px dashed var(--primary-color);
    border-bottom: 1px dashed var(--primary-color);
  }

  .input-container {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .message-input{
    color: var(--primary-color);
    background-color: var(--secondary-color);
    border: 2px solid var(--primary-color);
    border-radius: 8px;
    height: 32px;
    width: 75%;
    padding-left: 10px;
  }
  .message-input:focus {
    outline: none;
    border:3px solid var(--primary-color);
  }
  .message-input::placeholder{
    color: var(--tertiary-color);
  }
  .text-input-button{
    width: 32px;
    height: 32px;
    border: 2px solid var(--primary-color);
    border-radius: 10px;
    background-color: var(--secondary-color);
    margin-left: 10px;
  }
  .text-input-button:active {
    transform: scale(0.95); /* Slightly scales down the button */
    background-color: rgba(0, 0, 0, 0.1); /* Adds a background color on press */
  }

  .mic-button{
    width: 48px;
    height: 32px;
    border: 2px solid var(--primary-color);
    border-radius: 10px;
    background-color: var(--secondary-color);
  }
  .mic-button:active {
    transform: scale(0.95); /* Slightly scales down the button */
    background-color: rgba(0, 0, 0, 0.1); /* Adds a background color on press */
  }
</style>