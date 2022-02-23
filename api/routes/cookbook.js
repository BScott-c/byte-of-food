export default function () {
  return {
    async getUserCookbooks (req, res) {
      // Get all cookbooks associated with a user
      res.enforcer?.send({
        bar: 'hello world, you\'ve retreived all users'
      })
    },
    async createCookbook (req, res) {
      // Create a cookbook
      res.enforcer?.send({
        bar: 'hello world, you\'ve retreived a user'
      })
    },
    async modifyCookbook (req, res) {
      // Modify a Cookbook
      res.enforcer?.send({
        bar: 'hello world'
      })
    }
  }
}