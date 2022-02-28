<template>
  <div>
    <b-jumbotron>
      <p>Welcome to the IT350 blog!</p>
    </b-jumbotron>
    <br />
    <div v-if="loading">Loading cookbooks....</div>
    <ul v-else>
      <li v-for="cookbook in cookbooks" :key="cookbook.cookbookid">
        <router-link :to="`cookbook/${cookbook.cookbookid}`">{{
          article.title
        }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "Home",
  data: function () {
    return {
      loading: false,
      cookbooks: [],
    };
  },
  created: function () {
    this.loading = true;
    Api.getCookbooks(this.$route.params.id).then((res) => {
      this.articles = res.data;
      this.loading = false;
    });
  },
};
</script>