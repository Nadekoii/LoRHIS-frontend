<template>
  <input-interface @sendedInput="handleSendedInput" @recognitionStarted="handleRecognitionStarted" @recognitionStopped="handleRecognitionStopped"/>
  <status-interface :eventLog="eventLog"/>
  <theme-button></theme-button>
</template>

<script setup>
import InputInterface from './components/InputInterface.vue'
import StatusInterface from './components/StatusInterface.vue'
import { ref } from 'vue';
import ThemeButton from "@/components/ThemeButton.vue";

// Variables
const eventLog = ref([]); 

const handleSendedInput = (userInput) => {
  logAdd('User sended: "' + userInput + '" at ' + new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }));
};
const handleRecognitionStarted = () => {
  logAdd('Voice input started at '+ new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }));
};
const handleRecognitionStopped = () => {
  logAdd('Voice input stopped at '+ new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }));
};

const logAdd = (log) => {
  eventLog.value.unshift(log);
  console.log(eventLog.value[0]);
}
</script>

<style scoped>
  div{
    height: 100%;
    width: 100%;
    text-align: center;
    padding-bottom: 15px;
  }
</style>
