<template>
  <div>
    <b-jumbotron>
      <p>Welcome to Byte of Food!</p>
    </b-jumbotron>
    
    <br />
    <div v-if="loading">Loading cookbooks....</div>
    <ul v-else>
      <CookbookList/>
    </ul>
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
      cookbooks: [],
    };
  },
  created: function () {
    this.loading = true;
    Api.getCookbooks().then((res) => {
      this.cookbooks = res.data;
      this.loading = false;
    });
  },
};
</script>