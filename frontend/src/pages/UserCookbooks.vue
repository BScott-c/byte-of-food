<template>
  <div>
    <div v-if="loading">Loading cookbooks....</div>
    <div v-else>
      <v-for>

      </v-for>
      <h1>{{ cookbook.title }}</h1>
      <p>{{ cookbook.content }}</p>
    </div>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "ArticleDetail",
  data: function () {
    return {
      loading: false,
      article: null,
    };
  },
  created: function () {
    this.loading = true;
    console.log(this.$route)
    Api.getSingleCookbook(2).then((res) => {
      this.article = res.data[0];
      this.loading = false;
    });
  },
};
</script>