<template>
  <b-container>
    <b-row>
      <b-col>
        <b-container class="mx-auto h-50 text-center">
        <h1>Your Cookbooks!</h1>
        </b-container>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-container class="mx-auto h-75 mb-1" align-v="center">
        <b-button pill variant="primary" @click="goToCreateCookbook()">Create Cookbook</b-button>
        </b-container>
        <div v-if="loading">Loading cookbooks....</div>
        <div v-else>
          <CookbookList v-bind:allCookbooks="this.cookbooks"></CookbookList>
        </div>  
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from "../auth";
import CookbookList from "../components/CookbookList.vue";

export default {
  name: "Home",
  components: {
    CookbookList,
  },
  data: function () {
    return {
      loading: false,
      cookbooks: [],
    };
  },
  created: function () {
    this.loading = true;
    const userId = getUserIdFromToken(getJwtToken());
    Api.getCookbooksForUser(userId).then((res) => {
      this.cookbooks = [...res.data];
      this.loading = false;
    });
  },
  methods: {
    goToCreateCookbook() {
      this.$router.push("/cookbook/create");
    },
  },
};
</script>