<template>
  <b-navbar toggleable type="dark" variant="info">
    <b-navbar-brand to='/'>
        <b-icon-journal-bookmark></b-icon-journal-bookmark>
        Byte Of Food
    </b-navbar-brand>
    <b-navbar-toggle target="navbar-toggle-collapse">
      <template #default="{ expanded }">
        <b-icon v-if="expanded" icon="chevron-bar-up"></b-icon>
        <b-icon v-else icon="chevron-bar-down"></b-icon>
      </template>
    </b-navbar-toggle>

    <b-collapse id="navbar-toggle-collapse" is-nav>
      <b-navbar-nav class="ml-auto">
        <b-nav-item to="/">Cookbooks</b-nav-item>
        <b-nav-item to="/">Favorite Recipes</b-nav-item>
        <b-button variant="warning" to="/Admin" v-if="AdminStatus">Admin Page</b-button>
        <b-button class="mt-2" variant="danger" to="/Logout">Logout</b-button>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from "../auth";

export default {
  name: "MobileAppBar",
  data: function () {
    return {
      loggedIn: false,
      AdminStatus: false
    };
  },
  created: function () {
    const user_id = getUserIdFromToken(getJwtToken())
    Api.getAdminStatus(user_id).then((res) => {
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