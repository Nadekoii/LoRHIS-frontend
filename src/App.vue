<template>
  <input-interface @sendedInput="handleSendedInput" @recognitionStarted="handleRecognitionStarted" @recognitionStopped="handleRecognitionStopped"/>
  <status-interface :eventLog="eventLog"/>
</template>

<script setup>
import InputInterface from './components/InputInterface.vue'
import StatusInterface from './components/StatusInterface.vue'
import { ref } from 'vue';

// Variables
const eventLog = ref([]);

const handleSendedInput = (userInput) => {
  logAdd('User sended: "' + userInput + '" at ' + new Date().toLocaleTimeString());
};
const handleRecognitionStarted = () => {
  logAdd('Voice input started at '+ new Date().toLocaleTimeString());
};
const handleRecognitionStopped = () => {
  logAdd('Voice input stopped at '+ new Date().toLocaleTimeString());
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
