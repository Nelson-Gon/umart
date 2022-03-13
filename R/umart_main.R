#' Generate random data for a UMAP
#'
#' @param seed Seed for reproducibility
#' @param type  Type of randomness to use, defaults to "norm" to generate data
#' from a normal distribution
#' @param number Number of samples to generate
#' @param ... Arguments to other functions.
#' @importFrom stats rnorm
#' @return A vector of the generated data, as requested.
#' @export
#'
#' @examples
#' generate_data(seed = 520, type ="norm", number = 50, mean = 233, sd = 0.5)

generate_data <- function(seed=520, type = "norm", number = 50,
                          ...
){

set.seed(seed)

switch(type,
       norm = rnorm(n = number, ...),
       uniform = runif(n= number, ...),
       poisson = rpois(n=number, ...)
       )


}

#' Run a UMAP
#'
#' @param seed Seed for reproducibility
#' @param neighbors Number of neighbors to use. Can be a single number or a
#' numeric vector.
#' @param df A data.frame/matrix with all numeric values
#' @param ... Other arguments to "umap::uwot".
#' @return A UMAP object
#' @export
#' @examples
#' \dontrun{
#' r_x <- generate_data(seed = 520, type ="norm", number = 50, mean = 233,
#' sd = 0.5)
#' r_y <- generate_data(seed = 520, type ="norm", number = 50, mean = 520,
#' sd = 0.05)
#' r_df <- data.frame(x = r_x, y = r_y)
#' run_umap(r_df, neighbors = 20, seed = 520)
#' }
run_umap <- function(df=NULL, neighbors = NULL, seed = 520, ...){
  set.seed(seed)
  umaps <- lapply(neighbors, function(x){
    u_map <- uwot::umap(df, n_neighbors = x, ...)
    umap_df <- data.frame(x= u_map[,1], y= u_map[,2])
    umap_df$neighbors <- x
    umap_df
  })
  do.call(rbind, umaps)

}

#' Generate umart
#' @param umap_df An object from run_umap
#' @param opacity controls background opacity
#' @param group_col Column to use to color UMAP result
#' @param use_palette Specifies a palette to use for the coloring
#' @param bg_color Specifies plot background color
#' @param use_geom Species the kind of geom to use. Defaults to geom_path
#' @importFrom methods getFunction
#' @return UMAP art (umart)
#' @export
#' @examples
#' r_x <- generate_data(seed = 520, type ="norm", number = 50, mean = 233,
#' sd = 0.5)
#' r_y <- generate_data(seed = 520, type ="norm", number = 50, mean = 520,
#' sd = 0.05)
#' r_df <- data.frame(x = r_x, y = r_y, group=rep(paste0("grp_", 1:5), 10))
#' umap_df <- run_umap(r_df[,-3], neighbors = 20, seed = 520)
#' generate_umart(umap_df, group_col = r_df$group)
#' @import ggplot2
#' @importFrom rlang .data
generate_umart <- function(umap_df, opacity = 0.25, group_col = NULL,
                           use_palette = "Spectral",
                           bg_color = "#b31c12",
                           use_geom = "geom_path"
                           ){
  ggplot(umap_df,aes(.data[["x"]], .data[["y"]], fill=group_col,
                     col = group_col))+
    getFunction(use_geom)(alpha=opacity) +
    coord_polar() +
    scale_fill_brewer(type = "div", palette = use_palette) +
    theme_minimal() +
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          panel.grid = element_blank(),
          panel.background = element_rect(color=bg_color,
                                          fill = bg_color),
          plot.background = element_rect(color=bg_color,
                                         fill = bg_color),
          title = element_blank()
    ) +
    guides(fill = "none", col="none")
}
