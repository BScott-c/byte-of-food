<template>
  <div >
    <div>
      <h1>Add a Recipe to "{{this.$route.params.cookbookname}}"</h1>  
      <div v-if="this.addNew">
        <AddNewRecipe @return="toggleAddNew()" />
      </div>
      <div v-else>
        <AddExistingRecipe v-bind:allRecipes="recipesNotInCookbook"/>
        <br /><br />
        <p>Don't see your recipe? </p>
        <button @click="toggleAddNew()">Create a Recipe</button>
      </div>
    </div>
  </div>
</template>

<script>
import Api from "../api";
import AddExistingRecipe from "../components/AddExistingRecipe.vue"
import AddNewRecipe from "../components/AddNewRecipe.vue"

export default {
  name: "AddRecipeToCookbook",
  components: {
    AddExistingRecipe,
    AddNewRecipe
  },
  data() {
    return {
      recipesNotInCookbook: [],
      loading: false,
      addNew: false,
      message: ""
    };
  },
  created: function () {
    console.log(this.$route)
    this.loading = true;
    Api.getRecipesNotInCookbook(this.$route.params.cookbookid).then((res) => {
      this.recipesNotInCookbook = [...res];
      this.loading = false;
    });
  },
  methods: {
    toggleAddNew () {
      this.addNew = !this.addNew
    }
  }
};
</script>
