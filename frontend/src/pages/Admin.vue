<template>
  <div>
    <b-row>
      <b-col>
        <h1>All Users</h1>
        <b-card
          border-variant="dark"
          header="Edit all users data carefully..."
          header-bg-variant="secondary"
          header-text-variant="white"
        >
          <UserList v-bind:allUsers="this.users"/>
        </b-card>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from "../auth";
import UserList from '../components/UserList';

export default {
  name: "Admin",
  components: {
    UserList
  },
  data: function () {
    return {
      loading: false,
      users: []
    };
  },
  created: function () {
    this.loading = true;
    const userId = getUserIdFromToken(getJwtToken());
    Api.getAllUsers(userId).then((res) => {
      this.users = [...res.data];
      this.loading = false;
    });
  }
};
</script>