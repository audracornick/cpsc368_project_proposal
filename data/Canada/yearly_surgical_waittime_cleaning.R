# using the year data
library(readxl)
library(dplyr)

df <- read_excel("2023_2024-annual-surgical_wait_times.xlsx")
yearly_wait <- read_excel("2023_2024-annual-surgical_wait_times.xlsx")

# Clean the WAITING and COMPLETED columns
yearly_wait <- yearly_wait %>%
  mutate(
    WAITING = gsub("<5", "5", WAITING),  # Replace "<5" with "5"
    COMPLETED = gsub("<5", "5", COMPLETED),  # Replace "<5" with "5"
    WAITING = as.numeric(WAITING),  # Convert WAITING to numeric
    COMPLETED = as.numeric(COMPLETED)  # Convert COMPLETED to numeric
  )

yearly_wait <- yearly_wait %>%
  mutate(Year = as.numeric(substr(FISCAL_YEAR, 1, 4))) %>%
  dplyr::select(-FISCAL_YEAR)  # Remove FISCAL_YEAR column

combined_data <- yearly_wait %>%
  group_by(Year, HEALTH_AUTHORITY, HOSPITAL_NAME, PROCEDURE_GROUP) %>%
  summarise(
    WAITING = sum(WAITING, na.rm = TRUE),  # Sum of waiting times
    COMPLETED = sum(COMPLETED, na.rm = TRUE),  # Sum of completed procedures
    COMPLETED_50TH_PERCENTILE = mean(COMPLETED_50TH_PERCENTILE, na.rm = TRUE),  # Average of 50th percentile
    COMPLETED_90TH_PERCENTILE = mean(COMPLETED_90TH_PERCENTILE, na.rm = TRUE),  # Average of 90th percentile
    .groups = 'drop'  # Ungroup after summarizing
  )

################ Reclassify
# Create a mapping of procedures to categories
procedure_mapping <- data.frame(
  PROCEDURE_GROUP = c(
    # Cardiovascular system: 5
    "Aortic Aneurysm Repair", "Endarterectomy", "Vascular Bypass Graft - Non Cardiac", "Vascular Surgery - Other",
    "Varicose Veins Ligation/Stripping",
    #Digestive system: 15
    "Abdominoplasty", "Appendectomy", "Bariatric Surgery", "Bowel Resection", "Cholecystectomy", "Colostomy/Ileostomy",
    "Esophagectomy", "Fistula Repair - Non Vascular", "Gastrostomy/Jejunostomy", "Hernia Repair - Abdominal",
    "Hernia Repair - Hiatal", "Laparoscopy", "Laparotomy", "Rectal Surgery", "Sphincterotomy",
    #Endocrine system: 1
    "Thyroidectomy", 
    #Eye and Vision System: 3
    "Cataract Surgery", "Lens & Vitreous (non-cataract) Surgery", "Other Eye Surgery",
    #Ear, Nose, and Throat System: 10
    "Mastoidectomy", "Myringotomy", "Nasal Surgery", "Other Ear Surgery", "Sinus Surgery", "Tonsillectomy/Adenoidectomy",
    "Tympanoplasty",  "Dental Surgery", "Oral Cavity & Pharynx Surgery", "Parotidectomy",
    # Female Reproductive Health: 6
    "Cone Biopsy", "D&C and Related Surgery", "Fallopian Tube/Ovarian Surgery", "Uterine Surgery",
    "Vaginal Repair", "Breast Biopsy", 
    # Male Reproductive System: 3
    "Excision Gynecomastia", "Male Reproductive Surgery", "Prostate Surgery",
    #Musculoskeletal System: 17
    "Foot/Ankle Surgery", "Fracture Repair", "Hand/Wrist Surgery", "Hip Replacement", "Knee - ACL Repair",
    "Knee - Meniscectomy", "Knee Arthroscopy", "Knee Replacement", "Ligament Surgery", "Other Joint Reconstruction",
    "Other Orthopaedic Surgery", "Shoulder Surgery", "Spinal/Back Surgery", "Tendon Surgery", "Facial Bone Reconstruction",
    "Rib Resection", "Hernia Repair - Chest Wall",
    # Nervous System: 4
    "Cranial Surgery", "CSF Drainage", "Nerve Surgery", "Shunt Insertion/Removal",
    # Respiratory System: 3
    "Lung Surgery", "Scope of Chest", "Thoracotomy",
    # Skin and Soft Tissue System:L 10
    "Cyst/Ganglion Removal", "Free Flap Graft", "Lipectomy", "Skin Surgery", "Skin Tumour Removal", "Wound/Laceration Care",
    "Excision Lesion/Tumour", "Breast Reconstruction", "Breast Reduction", "Mastectomy",
    # Urinary System: 3
    "Bladder Surgery", "Kidney/Bladder Stone Removal", "Other Urology Surgery",
    # General Procedures (Multiple Systems/Non-Specific): 4
    "All Other Procedures", "Biopsy in OR", "Examination Under Anaesthetic", "Foreign Body Removal Surgery",
    # All Procedure: 1
    "All Procedures"
  ),
  CATEGORY = c(
    rep("Cardiovascular System", 5),
    rep("Digestive System", 15),
    rep("Endocrine System", 1),
    rep("Eye and Vision System", 3),
    rep("Ear, Nose, and Throat System", 10),
    rep("Female Reproductive System", 6),
    rep("Male Reproductive System", 3),
    rep("Musculoskeletal System", 17),
    rep("Nervous System", 4),
    rep("Respiratory System", 3),
    rep("Skin and Soft Tissue System", 10),
    rep("Urinary System", 3),
    rep("General Procedures (Multiple Systems/Non-Specific)", 4),
    rep("All Procedures", 1)
  )
)

# Join the mapping with the original data
yearly_wait <- yearly_wait %>%
  left_join(procedure_mapping, by = "PROCEDURE_GROUP")

# Check for any unmatched procedures
if (any(is.na(yearly_wait$CATEGORY))) {
  warning("There are unmatched procedures in the original data.")
}
unmatched_procedures <- yearly_wait |> 
  filter(is.na(CATEGORY)) |> 
  distinct(PROCEDURE_GROUP)

print(unmatched_procedures)


# Group and summarize the data by category, year, health authority, and hospital name
combined_data <- yearly_wait %>%
  group_by(Year, HEALTH_AUTHORITY, HOSPITAL_NAME, CATEGORY) %>%
  summarise(
    WAITING = sum(WAITING, na.rm = TRUE),  # Sum of waiting times
    COMPLETED = sum(COMPLETED, na.rm = TRUE),  # Sum of completed procedures
    COMPLETED_50TH_PERCENTILE = mean(COMPLETED_50TH_PERCENTILE, na.rm = TRUE),  # Average of 50th percentile
   COMPLETED_90TH_PERCENTILE = mean(COMPLETED_90TH_PERCENTILE, na.rm = TRUE),  # Average of 90th percentile
    .groups = 'drop'  # Ungroup after summarizing
  )

# View the resulting combined data frame
print(combined_data)

write.csv(combined_data, "preprocessed_surgical_wait_times.csv")