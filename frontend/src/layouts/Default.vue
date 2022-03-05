<template>
  <div id="app">
    <AppBar />
    <b-container>
      <router-view></router-view>
    </b-container>
  </div>
</template>

<script>
import AppBar from '@/components/AppBar';

export default {
  name: "App",
  components: {
    AppBar
  },
};
</script>

<style>
</style>