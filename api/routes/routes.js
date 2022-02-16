export default function () {
  return {
    async getFoo (req, res) {
      res.enforcer?.send({
        bar: 'hello world'
      })
    }
  }
}