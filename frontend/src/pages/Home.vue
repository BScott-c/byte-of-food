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
import { getJwtToken, getUserIdFromToken } from '../auth';

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
    console.log(this.$route)
    const userId = getUserIdFromToken(getJwtToken())
    Api.getCookbooks(userId).then((res) => {
      this.articles = res.data;
      this.loading = false;
    });
  },
};
</script>