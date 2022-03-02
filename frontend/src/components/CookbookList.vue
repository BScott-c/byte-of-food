<template>
  <div>
    <div v-if="loading">Loading cookbooks....</div>
    <!-- <router-link to="admin/add" tag="b-button" class="float-right"
      >Add article</router-link
    > -->
    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Name</b-th>
          <b-th>Description</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="cookbook in cookbooks" :key="cookbook.cookbookid">
          <b-td><router-link :to="`cookbook/${cookbook.cookbookid}`">{{ cookbook.cookbookname }}</router-link></b-td>
          <b-td>{{ cookbook.cookbookdescription }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "CookbookList",
  data: function () {
    return {
      loading: false,
      cookbooks: [],
    };
  },
  created: function () {
    this.loadCookbooks();
  },

  methods: {
    loadCookbooks() {
      this.loading = true;
      this.cookbooks = [];
      Api.getCookbooks().then((res) => {
        this.cookbooks = res.data;
        this.loading = false;
      });
    }
  },
};
</script>
