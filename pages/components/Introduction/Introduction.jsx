import { Button, Heading, Box, Center, HStack, Img } from "@chakra-ui/react";
import React, { useRef } from "react";
import Link from "next/link";
import LinkButton from "../LinkButton/LinkButton";
import { Grid } from "@chakra-ui/react";
import { VStack, Stack } from "@chakra-ui/react";
import { getProviderOrSigner } from "../../../data/accountsConnection";
import { getCurrentConnectedOwner } from "../../../data/blockchainSpecificExports";
import { useSelector } from "react-redux";

function Introduction() {
  const selectedBlockchainInformation = useSelector(
    (state) => state.blockchain.value
  );
  let Blockchain = selectedBlockchainInformation.name;
  let NetworkChain = selectedBlockchainInformation.network;

  let bg = "black";
  let textColor = "white";
  //  _____
  let web3ModalRef = useRef();

  async function Connect() {
    await getCurrentConnectedOwner(Blockchain, NetworkChain, web3ModalRef);
  }

  return (
    <Box
      width={"100%"}
      color={textColor}
      height={"fit-content"}
      bg={"black"}
      paddingBottom={10}
      paddingTop={10}
    >
      <Stack
        spacing={[50, 30, 30, 10]}
        direction={["column", "column", "column", "row"]}
      >
        <VStack
          align={"left"}
          padding={20}
          paddingBottom={0}
          spacing={5}
          width={["100%", "100%", "100%", "60%"]}
          // paddingTop={["40vh", "40vh", "0vh"]}
          paddingTop={"15vh"}
        >
          <Heading
            fontSize={["2em", "4em", "5em"]}
            width={["80vw", "80vw", "80vw", "40vw"]}
          >
            Time to Rent Web3 Assets
          </Heading>
          <VStack
            width={["80vw", "80vw", "80vw", "40vw"]}
            spacing={4}
            align={"left"}
          >
            <Box fontSize={20} textColor={"whiteAlpha.800"}>
              RentWeb3 is a place where you can quickly start Renting your NFTs
              and Various Dapps.We provide you with a simple series of steps to
              get you help with whitelisting , presale and Public sale of your
              NFT Collection and Host them on one of the templates available or
              Rent NFTs at suitable prices.
            </Box>
            <Box fontSize={22} fontWeight={"700"}>
              So What are you waiting for ?
            </Box>
          </VStack>
          <HStack spacing={10}>
            <LinkButton
              href={"/Create"}
              title={"Upload Assets"}
              color={"green"}
              variant={"solid"}
              onClick={() => {
                Connect();
              }}
            />
            <LinkButton
              href={"/Explore"}
              title={"Explore Assets"}
              color={"blue"}
              variant={"solid"}
              onClick={() => {
                Connect();
              }}
            />
          </HStack>
        </VStack>

        <VStack
          paddingTop={["5vh", "2vh", "2vh", "0"]}
          bg={"black"}
          justifyContent={"center"}
          height={"100vh"}
        >
          <Img
            height={["90vh", "80vh", "fit-content"]}
            width={"90%"}
            border={"10px solid black"}
            borderRadius={"40px"}
            transition={"200ms all ease-in-out"}
            // borderLeft={"150px solid black"}
            // borderRight={"150px solid black"}

            src="https://cdn.dribbble.com/users/1859790/screenshots/10750520/media/78cf0dccfeebd50268d23057e7568dac.png?compress=1&resize=1200x900&vertical=top"
            _hover={{
              transform: "scale(1.025)",
              cursor: "pointer",
            }}
          />
        </VStack>
      </Stack>
    </Box>
  );
}

export default Introduction;
