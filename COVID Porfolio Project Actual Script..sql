SELECT*
FROM PortfolioProject..CovidDeaths$
order by 3,4

--SELECT*
--FROM PortfolioProject..Covidvaccination$
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths$
order by 1,2
--Looking at Total cases vs Total deaths
select location, date, total_cases, total_deaths,(total_deaths/ total_cases)* 100 as DeathPercentage
FROM PortfolioProject..CovidDeaths$
Where location like '%states%'
order by 1,2
-- looking at total cases vs population 
select location, date, total_cases,population, (total_cases/population)*100 as Caseperpopulation
FROM PortfolioProject..CovidDeaths$
Where location like '%states%'
order by 1,2

--Looking at countries with highest infection rate compare to population
select location, Population, MAX(total_cases) as HighestinfectionCount, MAX((total_cases/population))*100 as Caseperpopulation
FROM PortfolioProject..CovidDeaths$
--Where location like '%states%'
Group by location, population
order by Caseperpopulation

SELECT*
FROM PortfolioProject..CovidDeaths$
WHERE continent is not null
Group by location 
ORDER by 3,4
 

SELECT continent, SUM(total_cases) AS total_cases, SUM(new_cases) AS new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent , total_deaths, population
ORDER BY total_cases, new_cases;

SELECT continent, MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount desc

SELECT location, MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount desc

-- looking  at total population vs total death
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVacinated/ population)8100
FROM PortfolioProject..CovidDeaths$ dea
join PortfolioProject..Covidvaccination$ vac
     on dea.location = vac.location
	 and dea.date = vac.date
	 Where dea.continent is not null
	 order by 2,3