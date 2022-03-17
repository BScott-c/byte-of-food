<template>
  <div id="app">
    <AppBar v-if="windowWidth > 900" />
    <MobileAppBar v-if="windowWidth <= 900" />
    <b-container>
      <router-view></router-view>
    </b-container>
  </div>
</template>

<script>
import AppBar from '@/components/AppBar';
import MobileAppBar from '@/components/MobileAppBar';

export default {
  name: "App",
  components: {
    AppBar,
    MobileAppBar
  },
    data() {
    return {
      windowWidth: window.innerHeight,
      success: false
    }
  },
  mounted() {
    window.onresize = () => {
      this.windowWidth = window.innerWidth
    }
  },
};
</script>

<style>
</style>