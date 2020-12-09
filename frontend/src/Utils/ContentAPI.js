import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { setContent, setSummaries } from '../Store/Actions'
import axios from 'axios'

import ReactHtmlParser from 'react-html-parser'

const apiRoot = '/api'
const apiPost = apiRoot + '/post'
const apiPostSummaries = apiRoot + '/post-summaries'

const renderRTF = (data) => {
  return ReactHtmlParser(data)
}

export const usePostByID = (id, raw=false) => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiPost, {params: {id, raw}})
      .then(resp => dispatch(setContent(renderRTF(resp.data.content))))
      .catch(() => dispatch(setContent('')))
    
      return () => dispatch(setContent(''))
  }, [])

  return useSelector(state => state.content)
}

export const createPost = (title, summary, data, tags) => {
  const post = {title: title, summary: summary, rawContent: data}
  axios.post(apiPost, post)
    .then(resp => console.log("Created", resp))
    .catch(resp => console.log("Error creating post", resp))
}

export const usePostSummaries = (numPosts) => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiPostSummaries, {params: {numPosts}})
      .then(resp => dispatch(setSummaries(resp.data.posts)))
      .catch(() => dispatch(setSummaries([])))
  }, [])

  return useSelector(state => state.summaries)
}

export const useUpdatePostSummaries = () => {
  const dispatch = useDispatch()

  axios.get(apiPostSummaries)
    .then(resp => dispatch(setSummaries(resp.data.posts)))
    .catch(() => dispatch(setSummaries([])))
}