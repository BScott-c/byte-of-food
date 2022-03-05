<template>
  <div>
    <h1>All Cookbooks</h1>
    <br /><br />
    <!-- <button @click="goToCreateCookbook()">Create Cookbook</button> -->
    <div v-if="loading">Loading cookbooks....</div>
    <div v-else><CookbookList v-bind:allCookbooks="this.cookbooks"></CookbookList></div>
  </div>
</template>

<script>
import Api from "../api";
import CookbookList from "../components/CookbookList.vue"

export default {
  name: "Home",
  components: {
    CookbookList
  },
  data: function () {
    return {
      loading: false,
      cookbooks: []
    };
  },
  created: function () {
    this.loading = true;
    Api.getCookbooks().then((res) => {
      this.cookbooks = [...res.data];
      this.loading = false;
    });
  },
  methods: {
    goToCreateCookbook () {
      this.$router.push('/cookbook/create')
    }
  }
};
</script>