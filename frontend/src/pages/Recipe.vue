<template>
  <div>
    <div>
      <router-link :to="`/cookbook/${this.$route.params.cookbookid}`" >« Back to Cookbook</router-link>

      <h1>{{recipe.recipename}}</h1>
      <h3>{{recipe.recipedescription}}</h3>
      <b-button v-if="this.canEdit" @click="toggleManage" title="Manage Recipe" :class="buttonClass">
                  <b-icon icon="pencil-square" variant="light" aria-hidden="true"></b-icon> Manage
              </b-button>
                
      <b-container class="bv-example-row mb-3">
        <b-row>
          <b-col>
            <RecipeInstructions :managingRecipe="managing" :instructions="recipe.recipeinstructions" :canEdit="canEdit" v-if="recipe.recipeinstructions || recipe.recipeinstructions === ''"/>
            </b-col>
          <b-col>
            <Equipment @equipmentSaved="reloadEquipment" :managingRecipe="managing" :recipeEquipment="equipment" :canEdit="canEdit" v-if="equipment || !equipment.length"/>
          </b-col>
        </b-row>
      </b-container>

      <b-container class="bv-example-row mb-3">
        <b-row>
          <b-col>
            <RecipeInstructions :managingRecipe="managing" :instructions="recipe.recipeinstructions" :canEdit="canEdit" v-if="recipe.recipeinstructions || recipe.recipeinstructions === ''"/>
          </b-col>
        </b-row>
      </b-container>
    </div>
  </div>
</template>

<script>
import Api from "../api";
import RecipeInstructions from "../components/RecipeInstructions.vue"
import Equipment from "../components/Equipment.vue"
import { getJwtToken, getUserIdFromToken } from '../auth';

export default {
  name: "Recipe",
  components: {
    RecipeInstructions,
    Equipment
  },
  computed: {
    buttonClass: function () {
      if (this.managing) return 'rounded bg-primary p-1'
      return 'rounded bg-info p-1'
    }
  },
  data: function () {
    return {
      loading: false,
      canEdit: false,
      managing: false,
      recipe: {},
      equipment: []
    };
  },
  created: async function () {
    this.loading = true;
    const userId = getUserIdFromToken(getJwtToken())
    await this.getRecipeInfo(userId)
    const recipeId = this.recipe.recipeid
    await this.getEquipmentInfo(recipeId)
    // TODO: get ingredient information
    this.loading = false
  },
  methods: {
    toggleManage() {
      if (this.canEdit){
        this.managing = !this.managing
      }
    },
    async getRecipeInfo(userId){
      const recipeRes = await Api.getRecipe([{dbparam: 'recipeid', value: this.$route.params.recipeid}])
      this.recipe = {...recipeRes.data[0]};
      if (recipeRes.data[0].userid == userId) this.canEdit = true
    },
    async getEquipmentInfo(recipeId){
      const equipmentRes = await Api.getRecipeEquipment(recipeId)
      this.equipment = [...equipmentRes.data]
    },
    reloadEquipment(){
      this.getEquipmentInfo(this.$route.params.recipeid).then(res => {
        console.log(res)
      })
    }
  }
};
</script>
