<template>
  <div>
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Name</b-th>
          <b-th>Description</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="cookbook in this.allCookbooks" :key="cookbook.cookbookid">
          <b-td><router-link :to="`/cookbook/${cookbook.cookbookid}`" >{{cookbook.cookbookname}}</router-link></b-td>
          <b-td>{{ cookbook.cookbookdescription }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>

export default {
  name: "CookbookList",
  props: {
    allCookbooks: {
      type: Array,
      required: true
    }
  }
};
</script>
