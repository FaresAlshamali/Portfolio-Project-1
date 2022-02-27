

--SELECT location , date , total_cases , new_cases , total_deaths, population
--FROM CovidDeaths$
--ORDER BY 1

--  Looking at Total Cases Vs Total Deaths in Jordan
SELECT location , date , total_cases , total_deaths ,
(total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths$
WHERE location Like '%Jordan%'
ORDER BY 2

-- Looking at Total Cases Vs Population in Jordan
-- Showing what percentage of population got Covid

SELECT location , date , total_cases , population ,
(total_cases/population)*100 as DeathPercentage
FROM CovidDeaths$
WHERE location Like '%Jordan%'
ORDER BY 2


-- Looking at countries with highest infection rate compared to Population
SELECT location , population , MAX(total_cases) as HighestInfectionCount , 
MAX((total_cases/population))*100 as PercentPopulationInfected
FROM CovidDeaths$
--WHERE location Like '%Jordan%'
GROUP BY location,population
ORDER BY 4 DESC

-- Showing the Countries with Highest Death Count 
SELECT location , population , MAX(CAST(total_deaths as int)) as TotalDeathCount 
FROM CovidDeaths$
WHERE continent is not NULL
GROUP BY location,population
--ORDER BY 3 DESC


-- Showing the summation of all Deaths in the world until 14 Feb 2022 
SELECT SUM(TotalDeathCount) as totalDeaths
FROM (
SELECT location , population , MAX(CAST(total_deaths as int)) as TotalDeathCount 
FROM CovidDeaths$
WHERE continent is not NULL
GROUP BY location,population
--ORDER BY 3 DESC
) t1

-- Deaths Count Sorting by the Continents 
SELECT location , population , MAX(CAST(total_deaths as int)) as TotalDeathCount 
FROM CovidDeaths$
WHERE continent is NULL
GROUP BY location,population
ORDER BY 3 DESC







-- Global Numbers
SELECT date , SUM(new_cases), SUM(cast(new_deaths as int) ) ,
SUM(cast(new_deaths as int) ) / SUM(new_cases) *100 as D
FROM CovidDeaths$
WHERE continent is not NULL
GROUP BY date
ORDER BY 1


-- Join Two Tables (Deaths & Vaccinations)
-- Looking at Total Population Vs Vaccination
SELECT D.continent , D.location, D.date, D.population ,MAX(V.new_vaccinations) AS maxV
FROM CovidDeaths$ D
JOIN CovidVaccinations$ V
On D.location = V.location AND D.date = V.date 
WHERE D.continent IS NOT NULL
GROUP BY D.continent , D.location, D.date, D.population
ORDER BY maxV desc


-- Looking at Max New Vaccinations Per Date
SELECT D.continent , D.location, D.date, D.population ,MAX(V.new_vaccinations) AS maxV
FROM CovidDeaths$ D
JOIN CovidVaccinations$ V
On D.location = V.location AND D.date = V.date 
WHERE D.continent IS NOT NULL
GROUP BY D.continent , D.location, D.date, D.population
ORDER BY maxV desc

