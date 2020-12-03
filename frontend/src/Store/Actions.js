export const setContent = (content) => (
    { type: 'SET_CONTENT', content }
)

export const setSummaries = (summaries) => {
    console.log("setting summary", summaries)
    return { type: 'SET_SUMMARIES', summaries }
}
