export const NewPost = (id = "", title = "", summary = "", content = "", tags="") => ({
    id,
    title,
    summary,
    content,
    tags
})

export const NewPostSummary = (id = "", title = "", summary = "") => ({
    id,
    title,
    summary
})
