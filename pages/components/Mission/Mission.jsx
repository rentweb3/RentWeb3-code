import {
  Box,
  Button,
  Card,
  Heading,
  HStack,
  Img,
  Stack,
  Text,
  VStack,
} from "@chakra-ui/react";
import React from "react";

function Mission() {
  function visitTwitter() {
    alert("Twitter account will be live soon !\nThank you for interest");
  }

  return (
    <Stack
      bg={"white"}
      color={"black"}
      direction={["column", "column", "column", "row"]}
      spacing={[20, 10, 10, 0]}
      padding={["100px", "50px", "30px", "10px"]}
      align={("space-between", "space-between", "center")}
    >
      <VStack
        padding={"100px"}
        height={["fit-content", "fit-content", "70vh"]}
        paddingLeft={"5vw"}
        paddingBottom={["10vh", "8vh", "6vh", "4vh"]}
        align={"left"}
        spacing={4}
      >
        <Heading fontSize={"3.5em"}>Our Mission</Heading>
        <Text fontSize={20} textColor={"black"} width={"40vw"}>
          Rentweb3 is on its mission to break the monoply of rich in web3 and
          make web3 assets affordable to almost everyone who could not addord
          these assets due to their high prices. A detailed view of our mission
          can be seen on our Twitter handle where we post each update.
        </Text>
        <Button
          width={"fit-content"}
          onClick={visitTwitter}
          colorScheme={"twitter"}
        >
          Visit Twitter
        </Button>
      </VStack>
      <Img
        justifyItems={"flex-end"}
        height={["80vh", "60vh", "60vh", "60vh"]}
        border={"1px solid black"}
        borderRadius={"50px"}
        src="https://believein.net/img/containers/main/projects/MortarPestle_BrandDevelopment/mp_projectimages_19_r.jpg/86ee68ff3b389554395cbc37a0a9a5b1.jpg"
      />
    </Stack>
  );
}

export default Mission;
