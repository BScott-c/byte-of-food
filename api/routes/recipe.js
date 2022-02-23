export default function () {
  return {
    async getRecipesInCookbook (req, res) {
      // Retreive a list of all recipes associated with a cookbook
      res.enforcer?.send({
        bar: 'hello world, you\'ve retreived all users'
      })
    },
    async createRecipeInCookbook (req, res) {
      // Create a new recipe in a cookbook
      res.enforcer?.send({
        bar: 'hello world, you\'ve retreived a user'
      })
    },
    async deleteCookbook (req, res) {
      // Delete a Cookbook
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async getRecipeById (req, res) {
      // Retreive information about a single recipe
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async modifyRecipe (req, res) {
      // Update a recipe's information
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async deleteRecipe (req, res) {
      // Update a recipe's information
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async getFavorites (req, res) {
      // Retreive all favorited recipes of a user
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async updateFavorites (req, res) {
      // Retreive all favorited recipes of a user
      res.enforcer?.send({
        bar: 'hello world'
      })
    }
  }
}