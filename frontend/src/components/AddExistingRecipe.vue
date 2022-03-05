<template>
  <div>
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th></b-th>
          <b-th>Name</b-th>
          <b-th>Description</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="recipe in this.allRecipes" :key="recipe.recipeid">
          <b-td><button @click="addRecipe()">+</button></b-td>
          <b-td>{{recipe.recipename}}</b-td>
          <b-td>{{ recipe.recipedescription }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>
//import Api from "../api"

export default {
  name: "AddExistingRecipe",
  props: {
    allRecipes: {
      type: Array,
      required: true
    }
  },
  methods: {
    addRecipe() {
      
    }
  }
};
</script>
