<template>
  <div>
    <!-- Image and text -->
    <b-navbar variant="info" type="dark">
      <b-navbar-brand to="/">
        <b-icon-journal-bookmark></b-icon-journal-bookmark>
        Byte Of Food
      </b-navbar-brand>
      <b-nav-text> Create to your hearts content... </b-nav-text>
      <b-navbar-nav class="ml-auto">
        <b-nav-item to="/">Cookbooks</b-nav-item>
        <b-nav-item to="/">Favorite Recipes</b-nav-item>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span v-if="AdminStatus">
          <b-button variant="warning" to="/Admin">Admin Page</b-button>
        </span>
        <b-button variant="danger" to="/Logout">Logout</b-button>
      </b-navbar-nav>
    </b-navbar>
  </div>
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from "../auth";

export default {
  name: "AppBar",
  data: function () {
    return {
      loggedIn: false,
      AdminStatus: false
    };
  },
  created: function () {
    Api.getAdminStatus(getUserIdFromToken(getJwtToken())).then((res) => {
      console.log("admin data: ", res.data[0]);
      if (res.data[0].isadmin) {
        this.AdminStatus = true;
      } else {
        this.AdminStatus = false;
      }
    });
  },
  setup() {},
};
</script>
