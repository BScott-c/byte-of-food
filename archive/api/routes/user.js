export default function () {
  return {
    async retreiveUsers (req, res) {
      // Get all users (must be admin)
      // IF req.params has isAdmin return T/F 
      res.enforcer?.send({
        bar: 'hello world, you\'ve retreived all users'
      })
    },
    async retreiveUser (req, res) {
      // Get a single user (must be admin)
      res.enforcer?.send({
        bar: 'hello world, you\'ve retreived a user'
      })
    },
    async createUser (req, res) {
      // Create a new user
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async modifyUser (req, res) {
      // Modify a user's information
      res.enforcer?.send({
        bar: 'hello world'
      })
    },
    async deleteUser (req, res) {
      // delete a user
      res.enforcer?.send({
        bar: 'hello world'
      })
    }
  }
}