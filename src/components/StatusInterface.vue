<template>
  <div class="right-div">
    <h2>System Status</h2>
    <div class="system-status-container">
      <div class="status-indicator" :class="{ online: mqttStatus, offline: !mqttStatus}"></div>
      <h4 :class="{ 'status-text': true, online: mqttStatus, offline: !mqttStatus}">{{ statusText }}</h4>
      <!--<button class="refresh-button" @click="refreshStatus">Refresh</button>-->
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
  /* Libraries */
  import{ ref,computed,onMounted,onUnmounted } from 'vue'; //reactive data - JS variable where Vue is aware of any changes to it => like data()
  import axios from 'axios';

  /* Lifecycle Hooks */
  // onMounted for connecting to WebSocket and refreshing status
  onMounted(() => {

    connectToWebSocket(); // Connect to WebSocket
    refreshStatus(); // Refresh status

    // Event listener for Keyboard Navigation
    document.addEventListener('keydown', (event) => { // ArrowUp and ArrowDown for scrolling event list
      const eventList = document.querySelector('.event-list');
      if (event.key === 'ArrowUp') {
        eventList.scrollTop -= 3;
      } else if (event.key === 'ArrowDown') {
        eventList.scrollTop += 3;
      }
    });
  });

  //onUnmounted for closing WebSocket
  onUnmounted(() => {
    if (websocket) {
      websocket.close();
    }
  });

  /* Variables */
  const mqttStatus = ref(false); // MQTT Status
  const uplinkStatus = ref(false); // Uplink Status
  const statusText = computed(() => { // Status Text (online if mqttStatus is true, offline if mqttStatus is false)
    if (mqttStatus.value) return 'ONLINE';
    else return 'OFFLINE';
  });
  const props = defineProps({
    eventLog: Array
  });
  let websocket = null; // WebSocket

  // Function to add log into eventLog
  const logAdd = (log) => {
    props.eventLog.unshift(log);
  }

  /* MQTT WebSocket */
  // Function to connect to WebSocket and refresh status using MQTT
  const connectToWebSocket = () =>{
    websocket = new WebSocket('ws://localhost:3001'); // TODO: Change to actual WebSocket URL
    websocket.onmessage = (message) => { // On message received
      let oldMqttStatus = mqttStatus.value; // Old MQTT Status
      const data = message.data; // Received data
      mqttStatus.value = data.size !== 0; // MQTT Status (true if data size is not 0, false otherwise)
      if (oldMqttStatus !== mqttStatus.value){ // If MQTT Status changed then log it
        logAdd('MQTT Check: ' + (mqttStatus.value ? 'ONLINE' : 'OFFLINE') + ' at ' + Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }));
      }
      console.log('MQTT Check: ' + (mqttStatus.value ? 'ONLINE' : 'OFFLINE'));
    };
  }

  /* Uplink API */
  // Function to refresh status using uplink API
  const refreshStatus = async () => {
    try {
      const response = await axios.post('http://localhost:3000/api/refreshStatus');
      console.log('API Response:', response.data);
      uplinkStatus.value = response.data.status;
      console.log('Updated Status:', uplinkStatus.value);
    } catch (error) {
      console.error('Error fetching status:', error);
      uplinkStatus.value = false;
    }
    logAdd('Uplink Check: ' + (uplinkStatus.value ? 'ONLINE' : 'OFFLINE') + ' at ' + new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }));
  };
</script>

<style scoped>
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
    width: 12px;
    height: 12px;
    border-radius: 50%;
    margin-top: 3px;
    margin-right: 5px;
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
    margin-left: 20px;
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