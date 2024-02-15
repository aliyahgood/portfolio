-- Nashville Housing: Data Cleaning 

SELECT * 
FROM NashvilleHousing

---------------------------------------------------------------------------------------------------------------------
--- Populate Property Address data

SELECT a.ParcelID, 
	a.PropertyAddress,
	b.ParcelID, 
	b.PropertyAddress,
	ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

---------------------------------------------------------------------------------------------------------------------
-- Break Address into Individual Columns (Address, City, State)

-- Property Address 
SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS City
FROM NashvilleHousing 


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(200)

UPDATE NashvilleHousing
SET PropertySplitAddress =  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(100)

UPDATE NashvilleHousing
SET PropertySplitCity =  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))


-- Owner Address

SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS Address,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS City,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS State
FROM NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(200)

UPDATE NashvilleHousing
SET OwnerSplitAddress =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(100)

UPDATE NashvilleHousing
SET OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)


ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(10)

UPDATE NashvilleHousing
SET OwnerSplitState =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


---------------------------------------------------------------------------------------------------------------------
-- Change SoldAsVacant to diplay 'Yes' or 'No' instead of 0 or 1
-- MSSM is being odd and not letting me directly update the rows, so I'll make a new row and assign it a Yes or No value

ALTER TABLE NashvilleHousing
ADD SoldAsVacant2 VARCHAR(3)

UPDATE NashvilleHousing
SET SoldAsVacant2 = 'No' 
WHERE SoldAsVacant = 0

UPDATE NashvilleHousing
SET SoldAsVacant2 = 'Yes' 
WHERE SoldAsVacant = 1

ALTER TABLE NashvilleHousing
DROP COLUMN SoldAsVacant

EXEC sp_rename 'NashvilleHousing.SoldAsVacant2', 'SoldAsVacant','COLUMN'


---------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates 

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					ParcelID
					) row_num
FROM NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1

---------------------------------------------------------------------------------------------------------------------
-- Delete Unused Columns 

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


-- Rename Address Columns 

EXEC sp_rename 'NashvilleHousing.PropertySplitAddress', 'PropertyAddress','COLUMN'

EXEC sp_rename 'NashvilleHousing.PropertySplitCity', 'PropertyCity','COLUMN'

EXEC sp_rename 'NashvilleHousing.OwnerSplitAddress', 'OwnerAddress','COLUMN'

EXEC sp_rename 'NashvilleHousing.OwnerSplitCity', 'OwnerCity','COLUMN'

EXEC sp_rename 'NashvilleHousing.OwnerSplitState', 'OwnerState','COLUMN'