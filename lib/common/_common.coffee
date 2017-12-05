class BaseCtrl
  alert: null
  alertError: (message)=>
    message = "Please contact system administrator - Unexpected error" if not message?
    @alert =
      type: 'danger'
      message: message
    @toaster.error(@alert.message) if @toaster?
    return

  alertSuccess: (message)=>
    @alert =
      type: 'success'
      message: message
    return

  clearError: =>
    @alert = null

  clone: (obj) ->
    if not obj? or typeof obj isnt 'object'
      return obj

    if obj instanceof Date
      return new Date(obj.getTime())

    if obj instanceof RegExp
      flags = ''
      flags += 'g' if obj.global?
      flags += 'i' if obj.ignoreCase?
      flags += 'm' if obj.multiline?
      flags += 'y' if obj.sticky?
      return new RegExp(obj.source, flags)

    newInstance = new obj.constructor()

    for key of obj
      newInstance[key] = @clone obj[key]

    return newInstance
