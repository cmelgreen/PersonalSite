import React from 'react'
import { Redirect } from 'react-router-dom'

const redirectKey = 'redirect'

const clearCookie = (cookie) => {
    document.cookie = cookie + '=""; max-age=-1'
}

const getCookieValue = (cookie) => {
    let value = document.cookie.match('(^|;)\\s*' + cookie + '\\s*=\\s*([^;]+)')
    return value ? value.pop() : ''
}

export const RedirectRequest = () => {
    const redirectTo = getCookieValue(redirectKey)
    clearCookie(redirectKey)

    return redirectTo ? <Redirect to={redirectTo} /> : null
}