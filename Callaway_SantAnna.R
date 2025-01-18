## Data

Reelection_Debt <- read.csv("~/Dropbox/Debt/Data/DS_Cohort_Debt.csv")
Reelection_Debt$Group <- as.numeric(Reelection_Debt$Group)

### Model framework ###

install.packages("did")
library(did)

install.packages("tidyverse")  # Install the package
library(tidyverse)             # Load the package



# Identify units treated in the first period and remove them
first_period <- min(Reelection_Debt$year)
treated_first_period <- Reelection_Debt %>%
  filter(year == first_period & Group != 0)

# Remove these units from the dataset
Reelection_Debt <- Reelection_Debt %>%
  filter(!(inegi %in% treated_first_period$inegi))




## ATT Method 

example_attgt <- att_gt(yname = "monto_original_contratado",
                        tname = "year",
                        idname = "inegi",
                        gname = "Group",
                        xformla = ~ 1,
                        panel = FALSE,
                        data = Reelection_Debt
)

summary(example_attgt)
ggdid(example_attgt)
