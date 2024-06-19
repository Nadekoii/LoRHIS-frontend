<template>
  <div class="right-div">
    <h2>System Status</h2>
    <div class="system-status-container">
      <div class="status-indicator" :class="{ online: status, offline: !status }"></div>
      <h4 :class="{ 'status-text': true, online: status, offline: !status }">{{ statusText }}</h4>
      <button class="refresh-button" @click="refreshStatus">Refresh</button>
    </div>
  </div>
</template>

<script setup>
  import{ ref,computed } from 'vue'; //reactive data - JS variable where Vue is aware of any changes to it => like data()

  const status = ref(true);
  const statusText = computed(() => (status.value ? 'ONLINE' : 'OFFLINE'));
  const refreshStatus = () => {
    status.value = !status.value;
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
    font-weight: bold;
  }

  .right-div{
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
    width: 23px;
    height: 23px;
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
    transform: scale(0.95); /* Slightly scales down the button */
    filter: brightness(110%); /* Darkens the button */
  }
</style>