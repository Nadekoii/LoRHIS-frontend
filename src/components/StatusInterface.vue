<template>
  <div class="right-div">
    <h2>System Status</h2>
    <div class="system-status-container">
      <div class="status-indicator" :class="{ online: status, offline: !status }"></div>
      <h4 :class="{ 'status-text': true, online: status, offline: !status }">{{ statusText }}</h4>
      <button class="refresh-button" @click="refreshStatus">Refresh</button>
    </div>
    <h4>Event Log</h4>
    <div class="event-list-wrapper">
      <ul class="event-list">
        <li class="event-element" v-for="(event, index) in eventLog" :key ="index">{{ event }}</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
  import{ ref,computed,onMounted,onUnmounted } from 'vue'; //reactive data - JS variable where Vue is aware of any changes to it => like data()
  import axios from 'axios';

  // onMounted / onUnmounted
  onMounted(() => {
    connectToWebSocket();
  });
  onUnmounted(() => {
    if (websocket) {
      websocket.close();
    }
  });

  // Variables
  const status = ref(false);
  const statusText = computed(() => (status.value ? 'ONLINE' : 'OFFLINE'));
  const props = defineProps({
    eventLog: Array
  });
  let websocket = null;

  const logAdd = (log) => {props.eventLog.unshift(log);
  }

  // WebSocket for MQTT
  const connectToWebSocket = () =>{
    websocket = new WebSocket('ws://localhost:3001');
    websocket.onmessage = (message) => {
      let oldstatus = status.value;
      const data = message.data;
      status.value = data.size !== 0;
      if (oldstatus !== status.value){
        logAdd('System Check: ' + (status.value ? 'ONLINE' : 'OFFLINE') + ' at ' + new Date().toLocaleTimeString());
      }
      console.log('System Check: ' + (status.value ? 'ONLINE' : 'OFFLINE'));
    };
  }

  // Uplink API
  const refreshStatus = async () => {
    try {
      const response = await axios.post('http://localhost:3000/api/refreshStatus');
      console.log('API Response:', response.data);
      status.value = response.data.status;
      console.log('Updated Status:', status.value);
    } catch (error) {
      console.error('Error fetching status:', error);
      status.value = false;
    }
    logAdd('Uplink Check: ' + (status.value ? 'ONLINE' : 'OFFLINE') + ' at ' + new Date().toLocaleTimeString());
  };
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
    font-size: 24px;
    font-weight: bold;
  }

  .right-div{
    flex-direction: column;
    justify-content: center;
    align-items: center;
    border-top-right-radius: 30px;
    border-bottom-right-radius: 30px;
    border: 1px dashed var(--primary-color);
  }
  .system-status-container{
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .status-indicator {
    display: inline-block;
    width: 16px;
    height: 16px;
    border: 1px solid black;
    border-radius: 50%;
    margin-right: 10px;
  }
  .status-indicator.online {
    background-color: var(--primary-color);
  }
  .status-indicator.offline {
    background-color: var(--pastel-red);
  }
  .status-text.offline {
    color: var(--pastel-red);
  }
  .refresh-button{
    width: 64px;
    height: 24px;
    color: var(--primary-color);
    border: 2px solid var(--primary-color);
    border-radius: 10px;
    background-color: var(--secondary-color);
    margin-left: 20px;
  }
  .refresh-button:active {
    transform: scale(0.95);
    filter: brightness(110%);
  }
  .event-list-wrapper {
    overflow: hidden;

  }
  .event-list {
    height: 125px;
    width: 380px;
    overflow-x: hidden;
    overflow-y: auto;
    margin: auto;
    text-align: center;
  }
  .event-list::-webkit-scrollbar {
    width: 16px;
  }
  .event-list::-webkit-scrollbar-thumb {
    background: var(--tertiary-color);
    border-radius: 8px;
  }
  .event-list::-webkit-scrollbar-thumb:hover {
    background: var(--primary-color);
  }
  .event-element{
    font-size: 16px;
    list-style-type: none;
    padding: 5px;
  }
</style>