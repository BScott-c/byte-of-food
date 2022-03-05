<template>
  <div>
    
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Name</b-th>
          <b-th>Description</b-th>
          <b-th>Privacy</b-th>
          <b-th>Actions</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="recipe in allRecipes" :key="recipe.recipeid">
          <b-td><router-link :to="`recipe/${recipe.recipeid}`">{{ recipe.recipename }}</router-link></b-td>
          <b-td>{{ recipe.recipedescription }}</b-td>
          <b-td v-if="recipe.isprivate === true">Private</b-td>
          <b-td v-else>Public</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>

export default {
  name: "RecipeList",
  props: {
    allRecipes: {
      type: Array,
      required: true
    }
  }
};
</script>
