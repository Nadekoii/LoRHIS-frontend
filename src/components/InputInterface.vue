<template>
  <div class="left-div">
    <h1>LORHIS</h1>
    <h4>Enter your text</h4>
    <div class="input-container">
      <input class="message-input" placeholder="Your message..." v-model.trim="userInput" :disabled="isSending || isRecording">
      <button class="text-input-button" @click="sendInput" :disabled="isSending || isRecording">
        <svg class="svg-icon" style=" width: 16px; height: 16px; vertical-align: middle; fill: var(--primary-color);overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M804.248575 157.915589l0 431.250908L393.361461 589.166497 393.361461 407.414013l-265.620613 227.143277 265.620613 227.01741L393.361461 679.95013l456.278931 0c25.086351 0 45.391816-20.36277 45.391816-45.39284L895.032208 157.915589 804.248575 157.915589 804.248575 157.915589zM804.248575 157.915589"  /></svg>
      </button>
    </div>
    <h4>or record your voice</h4>
    <button class="mic-button" :class="{ recording: isRecording }"  @click="voiceInput" :disabled="isSending">
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
  /* Libraries */
  import {ref, defineEmits, onMounted, onUnmounted} from 'vue'; //reactive data - JS variable where Vue is aware of any changes to it => like data()
  import { Buffer } from "buffer";
  import axios from 'axios';

  /* onMounted for event listeners (Keyboard Navigation) */
  onMounted(() => {
    // Selectors
    const inputField = document.querySelector('.message-input');
    const textInputButton = document.querySelector('.text-input-button');
    const micButton = document.querySelector('.mic-button');
    const refreshButton = document.querySelector('.refresh-button');
    const focusableElements = [textInputButton, micButton, refreshButton];

    let currentFocusIndex = 0;

    // Keyboard navigation
    document.addEventListener('keydown', (event) => {
      if (event.key.length === 1 && event.key.match(/[a-zA-Z0-9]/)) { // if the key is a letter or a number then focus inputField
        inputField.focus();
      } else if (event.key === 'ArrowLeft' && document.activeElement !== inputField) { // if the key is ArrowLeft and the active element is not inputField then focus the previous element
        currentFocusIndex = (currentFocusIndex - 1 + focusableElements.length) % focusableElements.length;
        focusableElements[currentFocusIndex].focus();
      } else if (event.key === 'ArrowRight' && document.activeElement !== inputField) { // if the key is ArrowRight and the active element is not inputField then focus the next element
        currentFocusIndex = (currentFocusIndex + 1) % focusableElements.length;
        focusableElements[currentFocusIndex].focus();
      }
    });
    inputField.addEventListener('keydown', (event) => { // if the key is Enter and the inputField is focused then send the input
      if (event.key === 'Enter' && !isSending.value && !isRecording.value) {
        sendInput();
      }
    });
  });

  /* Variables */
  const userInput = ref(''); // user's input
  const isSending = ref(false); // is the message sending ?
  const isRecording = ref(false); // is voice recognition active ?
  const emit = defineEmits(['sendedInput', 'recognitionStarted', 'recognitionEnded']); // emit events

  /* Downlink API */
  // Function to send the input to the back-end
  const sendInput = async () => {
    if (userInput.value !== '') {

      isSending.value = true; // Set isSending to true

      // Notify back-end the start of message with "/mStart"
      try {
        await axios.post('http://localhost:3000/api/sendInput', {userInput: '/mStart'});
      }catch(error){
      }

      // Algorithm to split the main message into multiple parts (Due to the bytes limit)
      const words = userInput.value.split(' ');
      let part = '';
      const parts = [];
      words.forEach(word => {
        const newPart = part ? part + ' ' + word : word;
        if (Buffer.byteLength(newPart, 'utf8') <50) {
          part = newPart;
        } else {
          console.log("part: " + Buffer.byteLength(part, 'utf8'));
          parts.push(part);
          part = word;
        }
      });
      if (part) parts.push(part); // Push the last part

      // For each to send each part to the back-end
      for (const part of parts) {
        try {
          await axios.post('http://localhost:3000/api/sendInput', { userInput: part });
        } catch (error) {}
        //await new Promise(resolve => setTimeout(resolve, 30000));
      }

      // Notify back-end the end of the message with "/mStop"
      try {
        await axios.post('http://localhost:3000/api/sendInput', {userInput: '/mStop'});
      }catch(error){
      }

      console.log('Messages sent successfully'); // Log to console
      emit('sendedInput', userInput.value); // Emit event
      userInput.value = ''; // Clear the input after sending
    }

    isSending.value = false; // Set isSending to false

  };

  /*
  const sendInput = async () => {
    if (userInput.value !== '') {
      try {
        // Notify with /mStart message
        await axios.post('http://localhost:3000/api/sendInput', { userInput: '/mStart' });
        // Split the main message into multiple parts
        const words = userInput.value.split(' ');
        let part = '';
        const parts = [];
        words.forEach(word => {
          if ((part + word).length <= 48) {
            part += (part ? ' ' : '') + word;
          } else {
            parts.push(part);
            part = word;
          }
        });
        if (part) parts.push(part);

        // For each to send each part
        for (const part of parts) {
          await axios.post('http://localhost:3000/api/sendInput', { userInput: part });
        }

        // Notify end of message with "/mStop" message
        await axios.post('http://localhost:3000/api/sendInput', { userInput: '/mStop' });
        console.log('Messages sent successfully');
      } catch (error) {
        console.error('Error sending input:', error);
        alert('Error sending input');
      }
      emit('sendedInput', userInput.value);
      userInput.value = ''; // Clear the input after sending
    }
  };
  */

  /* Voice Recognition */
  // Web Speech API
  if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window){ // only if the browser supports Web Speech API
    // WSA Constants
    const SpeechRecognition =
        window.SpeechRecognition || window.webkitSpeechRecognition;
    const SpeechGrammarList =
        window.SpeechGrammarList || window.webkitSpeechGrammarList;
    const SpeechRecognitionEvent =
        window.SpeechRecognitionEvent || window.webkitSpeechRecognitionEvent;
    // Variables
    const recognition = ref(new SpeechRecognition()); // create a new instance of SpeechRecognition
    recognition.value.continuous = true;              // keep recording until the user repress the button
    recognition.value.interimResults = true;          // updating result as long as the user is speaking
    recognition.value.lang = 'vi-VN';                 // set the language of the recognition to Vietnamese

    recognition.value.onstart = () => {
      emit('recognitionStarted');               // emit event on start of recognition
    };
    recognition.value.onend = () => {
      emit('recognitionStopped');               // emit event on end of recognition
    };
  }

  // Function to start and stop the voice recognition
  const voiceInput =() =>{
    if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {   // check if browser supports Web Speech API
      if (!isRecording.value) { // if not recording then start recording
        isRecording.value = true;
        recognition.value.start(); // start the recognition
        recognition.value.onresult = (event) => { // algorithm to get the result of the recognition (can be improved)
          userInput.value = Array.from(event.results)
              .map((result) => result[0])
              .map((result) => result.transcript)
              .join('');
          inputField.scrollLeft = inputField.scrollWidth;
        };
      }
      else { // otherwise stop recording
        isRecording.value = false;
        recognition.value.stop(); // stop the recognition
      }
    } else {
      alert('Speech recognition is not supported in your browser, consider to use Google Chrome or other browsers that support Web Speech API'); // alert if the browser does not support Web Speech API
    }
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
    font-size: 26px;
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
    margin: 5px;
  }
  .message-input:focus {
    outline: none;
    border:3px solid var(--primary-color);
  }
  .message-input::placeholder{
    color: var(--tertiary-color);
  }
  .message-input:disabled {
    opacity: 0.5;
    cursor: not-allowed;
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
    transform : scale(0.95);
    filter: brightness(110%);
  }
  .text-input-button:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
  .text-input-button:focus {
    outline: none;
    border:3px solid var(--primary-color);
  }

  .mic-button{
    width: 44px;
    height: 32px;
    border: 2px solid var(--primary-color);
    border-radius: 10px;
    background-color: var(--secondary-color);
    margin: 5px;
  }
  .mic-button.recording{
    transform : scale(0.95);
    filter: brightness(110%);
  }
  .mic-button:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
  .mic-button:focus{
    outline: none;
    border:3px solid var(--primary-color);
  }
</style>