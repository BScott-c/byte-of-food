<template>
<div>
  <!-- Image and text -->
  <b-navbar variant="faded" type="light">
    <b-navbar-brand href="#">
      <b-icon-journal-bookmark></b-icon-journal-bookmark>
      Byte Of Food
    </b-navbar-brand>
    <b-navbar-text>
      Create to your hearts content...
    </b-navbar-text>
    <b-navbar-nav>
      <b-nav-item to="/">Cookbooks</b-nav-item>
      <b-nav-item to="/">Favorite Recipes</b-nav-item>
      <b-button to="/Logout">Logout</b-button>
    </b-navbar-nav>
  </b-navbar>
</div>
</template>

<script>

export default {
    name: "AppBar",
    data: function () {
      return {
        loggedIn: false
      }
    },
    created: function () {

    },

    methods: function () {
      return {
        Logout: function () {

        }
      }
    },
    setup() {
        
    },
};
</script>
